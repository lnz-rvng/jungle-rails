require 'rails_helper'

RSpec.describe Product, type: :model do
  describe 'Validations:' do
    # validation tests/examples here
    describe 'Given all valid parameters' do
      it 'saves succesfully' do
        @category = Category.create( name: 'Test')
        @product = Product.new(
          name: 'Test',
          price: 420,
          quantity: 69,
          category: @category
        )

        expect(@product).to be_valid
        expect(@product.save).to be true
      end
    end

    describe 'given a nil name' do
      it 'saves unsuccesfully' do
        @category = Category.create( name: 'Test')
        @product = Product.new(
          name: nil,
          price: 420,
          quantity: 69,
          category: @category
        )

        expect(@product).not_to be_valid
        expect(@product.errors.full_messages).to include("Name can't be blank")
      end
    end

    describe 'given a nil price' do
      it 'saves unsuccesfully' do
        @category = Category.create( name: 'Test')
        @product = Product.new(
          name: 'Test',
          price_cents: nil,
          quantity: 69,
          category: @category
        )

        expect(@product).not_to be_valid
        expect(@product.errors.full_messages).to include("Price can't be blank")
      end
    end

    describe 'given a nil quantity' do
      it 'saves unsuccesfully' do
        @category = Category.create( name: 'Test')
        @product = Product.new(
          name: 'Test',
          price: 420,
          quantity: nil,
          category: @category
        )

        expect(@product).not_to be_valid
        expect(@product.errors.full_messages).to include("Quantity can't be blank")
      end
    end

    describe 'given a nil category' do
      it 'saves unsuccesfully' do
        @category = Category.create( name: 'Test')
        @product = Product.new(
          name: "Test",
          price: 420,
          quantity: 69,
          category: nil
        )

        expect(@product).not_to be_valid
        expect(@product.errors.full_messages).to include("Category must exist")
      end
    end
  end
end
