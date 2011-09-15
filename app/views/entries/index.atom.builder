atom_feed :language => 'en-US' do |feed|
  feed.title Settings.app.feed_title
  feed.updated Time.now

  @entries.each do |item|
    next if item.created_at.blank?

    feed.entry( item ) do |entry|
      entry.url entry_url(item)
      entry.title item.title
      entry.content item.body_html, :type => 'html'

      # the strftime is needed to work with Google Reader.
      entry.updated(item.created_at.strftime("%Y-%m-%dT%H:%M:%SZ")) 
      entry.author item.user
    end
  end
end
