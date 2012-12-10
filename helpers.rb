module SlimConvertable

  def convert(slim_source)
    template = Slim::Template.new{ slim_source }
    template.render({})
  end

end