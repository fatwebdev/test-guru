module Admin::GistsHelper
  def get_hash(url)
    url.split('/').last
  end
end
