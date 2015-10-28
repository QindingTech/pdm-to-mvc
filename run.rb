require 'carnelian/executor'
require 'nokogiri'
require 'yaml'
# ×Ö·û´¦ÀíÀà
class String
  def uncapitalize
    self[0, 1].downcase + self[1..-1]
  end

  def capitalizeFirst
    self[0, 1].upcase + self[1..-1]
  end

  def hyphen
    self.gsub(/::/, '/').
        gsub(/([A-Z]+)([A-Z][a-z])/, '\1-\2').
        gsub(/([a-z\d])([A-Z])/, '\1-\2').downcase
  end
end

class ColumnClass
  def initialize(type, name, code, comment)
    @type=type
    @name=name
    @code=code
    @comment=comment
  end

  def type
    @type
  end

  def name
    @name
  end

  def code
    @code
  end

  def comment
    @comment
  end
end

# convert database type to Java type
def getType(dbType)
  type = dbType.downcase
  if type.start_with?('timestamp')
    return 'Date'
  elsif type.start_with?('varchar')
    return 'String'
  elsif type.start_with?('int')
    return 'Long'
  elsif type.start_with?('text')
    return 'String'
  elsif type.start_with?('date')
    return 'Date'
  elsif type.start_with?('decimal')
    return 'BigDecimal'
  elsif type.start_with?('numeric')
    return 'BigDecimal'
  else
    return 'String'
  end
end

# create directory if it's not exist
def createDir(path)
  dirname = File.dirname(path)
  tokens = dirname.split(/[\/\\]/) # don't forget the backslash for Windows! And to escape both "\" and "/"
  1.upto(tokens.size) do |n|
    dir = tokens[0...n]
    path = dir.join('/')
    Dir.mkdir(path) unless Dir.exist?(path)
  end
end


$year = Time.now.year

cnf = YAML::load(File.open('config_webclerk.yml'))

pdmPath = cnf['pdmPath']

entityFolder = cnf['entityFolder']
dtoFolder = cnf['dtoFolder']

daoFolder = cnf['daoFolder']
daoImplFolder= cnf['daoImplFolder']
serviceFolder = cnf['serviceFolder']
serviceImplFolder = cnf['serviceImplFolder']
controllerFolder = cnf['controllerFolder']
jspFolder = cnf['jspFolder']


# read powerdesigner pdm file
@doc = Nokogiri::XML(File.read(pdmPath))
tables = @doc.xpath('//c:Tables/o:Table')

$groupNames = Hash.new

createDir(entityFolder+'stub')
createDir(dtoFolder+'stub')

# generate hibernate entity
tables.each do |table|
  # puts table.xpath('.//a:Name')
  $entityName = table.xpath('a:Name')[0].content
  $tableName = table.xpath('a:Code')[0].content
  gName = $entityName
  if !table.xpath('a:Stereotype')[0].nil?
    gName=table.xpath('a:Stereotype')[0].content
  end
  $groupNames.store(gName, gName)

  $entityComment = ''
  if !table.xpath('a:Comment')[0].nil?
    $entityComment = table.xpath('a:Comment')[0].content
  end
  $attributes = table.xpath('.//o:Column')

  $columnArray = Array.new
  $attributes.each do |attribute|

    if attribute['Id'].nil?
      next
    end

    typeNode = attribute.xpath('a:DataType')[0]
    nameNode = attribute.xpath('a:Name')[0]
    codeNode = attribute.xpath('a:Code')[0]
    commentNode = attribute.xpath('a:Comment')[0]

    type='String'
    if !typeNode.nil?
      type =getType(attribute.xpath('a:DataType')[0].content)
    end

    name=''
    if !nameNode.nil?
      name=nameNode.content
    end

    code=''
    if !codeNode.nil?
      code=codeNode.content
    end

    comment=''
    if !commentNode.nil?
      comment=commentNode.content
    end
    column = ColumnClass.new(type, name, code, comment)
    $columnArray.push(column)
  end

  entityFullPath = entityFolder+$entityName+'.java'
  CarnelianExecutor.execute_metaprogram_to_file 'template/entity.mp', entityFullPath
  puts $entityName+'.java is created.'

  if !$entityName.end_with?('Arc')
    # voFullPath = entityFolder+$entityName+'Vo.java'
    # CarnelianExecutor.execute_metaprogram_to_file 'template/vo.mp', voFullPath
    # puts $entityName+'Vo.java is created.'


    dtoFullPath = dtoFolder+$entityName+'Dto.java'
    CarnelianExecutor.execute_metaprogram_to_file 'template/dto.mp', dtoFullPath
    puts $entityName+'Dto.java is created.'
  end
end

# generate dao,service,controller
$groupNames.each_key do |gn|

  $groupName = gn

  if gn.end_with?('Arc')
    next
  end

  daoFullPath = daoFolder+gn+'Dao.java'
  daoImplFullPath = daoImplFolder+gn+'DaoImpl.java'
  serviceFullPath = serviceFolder+gn+'Service.java'
  serviceImplFullPath = serviceImplFolder+gn+'ServiceImpl.java'
  controllerFullPath = controllerFolder+gn+'Controller.java'

  createDir(daoFullPath)
  createDir(daoImplFullPath)
  createDir(serviceFullPath)
  createDir(serviceImplFullPath)
  createDir(controllerFullPath)

  CarnelianExecutor.execute_metaprogram_to_file 'template/dao.mp', daoFullPath
  puts gn+'Dao.java is created'
  CarnelianExecutor.execute_metaprogram_to_file 'template/dao_impl.mp', daoImplFullPath
  puts gn+'DaoImpl.java is created'
  CarnelianExecutor.execute_metaprogram_to_file 'template/service.mp', serviceFullPath
  puts gn+'Service.java is created'
  CarnelianExecutor.execute_metaprogram_to_file 'template/service_impl.mp', serviceImplFullPath
  puts gn+'ServiceImpl.java is created'
  CarnelianExecutor.execute_metaprogram_to_file 'template/controller.mp', controllerFullPath
  puts gn+'Controller.java is created'

end


