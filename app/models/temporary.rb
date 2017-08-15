class Temporary < ApplicationRecord

  def self.save_temporary(ids)
    self.destroy_all
    ActiveRecord::Base.connection.execute('ALTER TABLE temporaries AUTO_INCREMENT = 1')
    temporaries = []
    ids.each do |id|
      temporaries << Temporary.new(follower_id: id)
    end
    Temporary.import temporaries
  end
end
