require 'carnelian/executor'
require 'nokogiri'
require 'yaml'
require_relative 'pdm_helper'


cnf = YAML::load(File.open('config_webclerk.yml'))

pdmFiles = cnf['pdmFiles']
puts pdmFiles

entityFolder = cnf['entityFolder']
dtoFolder = cnf['dtoFolder']
daoFolder = cnf['daoFolder']
daoImplFolder= cnf['daoImplFolder']
serviceFolder = cnf['serviceFolder']
serviceImplFolder = cnf['serviceImplFolder']
controllerFolder = cnf['controllerFolder']
jspFolder = cnf['jspFolder']

# String helper
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

# Create Folder
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



def processTemplates(pdmFile, entityFolder, dtoFolder,daoFolder,daoImplFolder,serviceFolder,serviceImplFolder,controllerFolder,jspFolder)
  createDir(entityFolder+'stub')
  createDir(dtoFolder+'stub')
  createDir(daoFolder+'stub')
  createDir(daoImplFolder+'stub')
  createDir(serviceFolder+'stub')
  createDir(serviceImplFolder+'stub')
  createDir(controllerFolder+'stub')
  createDir(controllerFolder+'stub')
  createDir(jspFolder+'stub')

  # $groupNames
  # $entityName
  # $tableName
  # $columnArray
  # $entityComment

  @doc = Nokogiri::XML(File.read(pdmFile))
  tables = @doc.xpath('//c:Tables/o:Table')

  $groupNames = Hash.new

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
        type =PdmHelper.getJavaTypeFromDb(attribute.xpath('a:DataType')[0].content)
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
end


pdmFiles.each do |pdmFile|
  puts "Processing pdm file #{pdmFile}"
  processTemplates(pdmFile, entityFolder, dtoFolder,daoFolder,daoImplFolder,serviceFolder,serviceImplFolder,controllerFolder,jspFolder)
end


