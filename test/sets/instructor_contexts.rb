module Contexts
  module InstructorContexts
    def create_instructors
      @mark   = FactoryBot.create(:instructor, user: @user_mark, first_name: "Mark")
      @alex   = FactoryBot.create(:instructor, user: @user_alex, first_name: "Alex", bio: nil)
      @rachel = FactoryBot.create(:instructor, user: @user_rachel, first_name: "Rachel", bio: nil, active: false)
    end

    def delete_instructors
      @mark.delete
      @alex.delete
      @rachel.delete
    end

    def create_more_instructors
      @brad     = FactoryBot.create(:instructor, user: @user_brad, first_name: "Brad", last_name: "Hess", bio: "A stupendous chess player as you have ever seen.")
      @ripta    = FactoryBot.create(:instructor, user: @user_ripta, first_name: "Ripta", last_name: "Pasay", bio: "A stupendous chess player as you have ever seen.")
      @jon      = FactoryBot.create(:instructor, user: @user_jpn, first_name: "Jon", last_name: "Hersh", bio: "A stupendous chess player as you have ever seen.")
    end

    def delete_more_instructors
      @brad.delete
      @ripta.delete
      @jon.delete
    end
  end
end