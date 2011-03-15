module TagsHelper

  def get_tag_class(fact, tag)
    if fact.tags.include?(tag)
      "clicked"
    else
      ""
    end
  end

end
