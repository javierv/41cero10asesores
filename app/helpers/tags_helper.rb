module TagsHelper
  def buttons(&block)
    content_tag :div, class: "buttons" do
      block.call
    end
  end

  def listado(&block)
    content_tag :section, id: "listado" do
      block.call
    end
  end
end
