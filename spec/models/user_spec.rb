require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'Validations' do
    describe 'Passwords:' do
      it 'requires password field' do
        @user = User.new(
          first_name: "John",
          last_name: "Doe",
          email: "test@test.com",
          password: "",
          password_confirmation: "test123"
        )

        expect(@user).not_to be_valid
        expect(@user.errors.full_messages).to include("Password can't be blank")
      end

      it 'requires password confirmation field' do
        @user = User.new(
          first_name: "John",
          last_name: "Doe",
          email: "test@test.com",
          password: "test12345",
          password_confirmation: ""
        )

        expect(@user).not_to be_valid
        expect(@user.errors.full_messages).to include("Password confirmation doesn't match Password")
      end
      describe 'Password length' do
        it 'is invalid if password is too short' do
          @user = User.new(
            first_name: "John",
            last_name: "Doe",
            email: "test@test.com",
            password: "test123",
            password_confirmation: "test123"
          )

          expect(@user).not_to be_valid
          expect(@user.errors.full_messages).to include("Password is too short (minimum is 8 characters)")
        end
        it 'is valid if password is long enough' do
          @user = User.new(
            first_name: "John",
            last_name: "Doe",
            email: "test@test.com",
            password: "test12345",
            password_confirmation: "test12345"
          )

          expect(@user).to be_valid
        end
      end
    end

    describe 'Email:' do
      it 'requires a unique email (case sensitive)' do
        User.create(
          first_name: "John",
          last_name: "Doe",
          email: "test@test.COM",
          password: "test12345",
          password_confirmation: "test12345"
        )

        @user_with_same_email = User.new(
          first_name: "Doe",
          last_name: "John",
          email: "TEST@TEST.com",
          password: "test12345",
          password_confirmation: "test12345"
        )

        expect(@user_with_same_email).not_to be_valid
        expect(@user_with_same_email.errors.full_messages).to include("Email has already been taken")
      end

      it 'requires the presence of an email' do
        @user = User.new(
          first_name: "John",
          last_name: "Doe",
          email: "",
          password: "test12345",
          password_confirmation: "test12345"
        )

          expect(@user).not_to be_valid
          expect(@user.errors.full_messages).to include("Email can't be blank")
      end
    end

    describe 'Name:' do
      it 'requires the presence of a first name' do
        @user = User.new(
          first_name: "",
          last_name: "Doe",
          email: "test@test.com",
          password: "test12345",
          password_confirmation: "test12345"
        )

          expect(@user).not_to be_valid
          expect(@user.errors.full_messages).to include("First name can't be blank")
      end
      it 'requires the presence of a last name' do
        @user = User.new(
          first_name: "John",
          last_name: "",
          email: "test@test.com",
          password: "test12345",
          password_confirmation: "test12345"
        )

          expect(@user).not_to be_valid
          expect(@user.errors.full_messages).to include("Last name can't be blank")
      end
    end
  end

  describe '.authenticate_with_credentials' do
    # examples for this class method here
    it 'authenticates with valid email and password' do
      @user = User.create(
        first_name: "John",
        last_name: "Doe",
        email: "john.doe@example.com",
        password: "test12345",
        password_confirmation: "test12345"
      )

      @authenticated_user = User.authenticate_with_credentials("john.doe@example.com", "test12345")
      expect(@authenticated_user).to eq(@user)
    end

    it 'does not authenticate with invalid password' do
      @user = User.create(
        first_name: "John",
        last_name: "Doe",
        email: "john.doe@example.com",
        password: "test12345",
        password_confirmation: "test12345"
      )

      @authenticated_user = User.authenticate_with_credentials("john.doe@example.com", "wrongtest12345")
      expect(@authenticated_user).not_to eq(@user)
    end

    it 'authenticates with email case insensitively' do
      @user = User.create(
        first_name: "John",
        last_name: "Doe",
        email: "john.doe@example.com",
        password: "test12345",
        password_confirmation: "test12345"
      )

      @authenticated_user = User.authenticate_with_credentials("john.DOE@EXAMPLE.com", "test12345")
      expect(@authenticated_user).to eq(@user)
    end

    it 'authenticates email with spaces' do
      @user = User.create(
        first_name: "John",
        last_name: "Doe",
        email: "john.doe@example.com",
        password: "test12345",
        password_confirmation: "test12345"
      )

      @authenticated_user = User.authenticate_with_credentials(" john.doe@example.com ", "test12345")
      expect(@authenticated_user).to eq(@user)
    end
  end
end
