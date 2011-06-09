xml.instruct! :xml, :version => "1.0"
xml.rss :version => "2.0" do
  xml.channel do
    xml.title "Knowledge Base"
    xml.description "Remembering every single knowledge"
    xml.link facts_url

    for fact in @facts
      xml.item do
        xml.title fact.title
        xml.description fact.description
        xml.publication fact.created_at.to_s(:rfc822)
        xml.author fact.user.name
        xml.link fact_url(fact)
        xml.guid fact_url(fact)
      end
    end
  end
end
