class Gif < ActiveRecord::Base
  acts_as_voteable
  acts_as_taggable
  paginates_per 30
  belongs_to :user
  attachment :gif_image, content_type: ["image/gif"]
  validates :description, presence: true
  validates :url, length: { minimum: 12, too_short: "not long enough" }, allow_blank: true
  validates :url, uniqueness: true, allow_blank: true
  validates :url, format: { with: /\Ahttps?:\/\// }, allow_blank: true
  validates :url, format: { with: /.gif\Z/ }, allow_blank: true
  validate :has_either_url_or_image

  scope :by_score, -> { joins("LEFT OUTER JOIN votes ON gifs.id = votes.voteable_id AND votes.voteable_type = 'Gif'").
                   group('gifs.id').
                   order('SUM(CASE votes.vote WHEN true THEN 1 WHEN false THEN -1 ELSE 0 END) DESC')
                 }

  private

  def has_either_url_or_image
    unless url.blank? ^ gif_image.blank?
      errors.add(:base, "Specify a url or upload an image, not both")
    end
  end

end
