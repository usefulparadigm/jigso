# to solve JST naming gotcha
# https://github.com/documentcloud/jammit/issues/192

Jammit::Compressor.class_eval do
  private
  def find_base_path(path)
    File.expand_path(Rails.root.join('app','templates'))
  end
end
