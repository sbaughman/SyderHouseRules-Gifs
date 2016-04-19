class Gif < ActiveRecord::Base
  acts_as_voteable
  acts_as_taggable
  paginates_per 30
  belongs_to :user
  attachment :gif_image
  validates :url, :description, presence: true
  validates :url, length: { minimum: 12, too_short: "not long enough" }
  validates :url, uniqueness: true
  validates :url, format: { with: /\Ahttps?:\/\// }
  validates :url, format: { with: /.gif\Z/ }

  scope :by_score, -> { joins("LEFT OUTER JOIN votes ON gifs.id = votes.voteable_id AND votes.voteable_type = 'Gif'").
                   group('gifs.id').
                   order('SUM(CASE votes.vote WHEN true THEN 1 WHEN false THEN -1 ELSE 0 END) DESC')
                 }

end
