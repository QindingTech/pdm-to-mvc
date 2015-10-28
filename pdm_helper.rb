class PdmHelper
  # convert database type to Java type
  def self.getJavaTypeFromDb(dbDataType)
    type = dbDataType.downcase
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
