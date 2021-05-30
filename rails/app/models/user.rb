class User < ApplicationRecord
    has_many :reviews
    has_many :orders

    def self.current_user_id(cookies)
        if cookies[:user_id]
            return cookies[:user_id]
        else
            return nil
        end
    end

    def self.current_user(cookies)
        if cookies[:user_id]
            return self.where("id = ?", cookies[:user_id]).first
        else
            return nil
        end
    end

    def self.get_user_id(name, password)
        return self
                .select(:id, :name, :password)
                .where("(name = ?) AND (password = ?)", name, password)
                .map{|u| u.id}
    end
end
