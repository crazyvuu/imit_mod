class TestObject < ActiveRecord::Base
  def as_json(params=nil)
    obj = {
        id: self.id,
        user_id: self.user_id,
        title: self.title,
        ts: self.ts,
        is_deleted: self.is_deleted
    }.reject { |k, v| v.nil? }
    obj
  end
end