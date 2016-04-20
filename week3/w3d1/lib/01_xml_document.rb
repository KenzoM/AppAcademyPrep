class XmlDocument
  attr_accessor :indent, :level
  def initialize(indent = false, level = 0)
    @indent = indent
    @level = level
  end
  def method_missing(tag_name, *attrs, &block)
    attrs = attrs[0] || {} #takes the first one from attrs.splat array or empty hash
    render(tag_name, attrs, &block)
  end

  def render(tag_name, attrs, &block)
    output = ""
    if block_given?
      output << open_tag(tag_name,attrs)
      @indent == true ? output << indent : ""
      output << block.call
      @indent == true ? output << de_indent : ""
      output << close_tag(tag_name)
    else
      output << lone_tag(tag_name, attrs)
    end
  end

  def lone_tag(tag, attrs)
    #tag = tag.to_s
    attr_text = attribute_render(attrs)
    "<#{tag}#{attr_text}/>#{newline}"
  end

  def attribute_render(attrs)
    text_output = ""
    attrs.each do |key,value|
      text_output = " #{key}=\"#{value}\""
    end
    text_output
  end

  def open_tag(tag, attrs)
    #tag = tag.to_s
    attr_text = attribute_render(attrs)
    "<#{tag}#{attr_text}>#{newline}"
  end

  def close_tag(tag)
    #tag = tag.to_s
    "</#{tag}>#{newline}"
  end

  def indent
    @level += 1
    "  " * @level
  end

  def de_indent
    @level -= 1
    "  " * @level
  end

  def newline
    new_line = ""
    @indent == true ? new_line = "\n" : ""
  end
end
