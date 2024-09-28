require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'ユーザー新規登録' do
    before do
      @user = User.new(
        nickname: 'testuser',
        first_name: '太郎',
        last_name: '山田',
        first_name_kana: 'タロウ',
        last_name_kana: 'ヤマダ',
        date_of_birth: '1990-01-01',
        email: 'test@example.com',
        password: 'password123',
        password_confirmation: 'password123'
      )
    end

    it 'nicknameが空では登録できない' do
      @user.nickname = ''
      @user.valid?
      expect(@user.errors.full_messages).to include("Nickname can't be blank")
    end

    it 'first_nameが空では登録できない' do
      @user.first_name = ''
      @user.valid?
      expect(@user.errors.full_messages).to include("First name can't be blank")
    end

    it 'first_nameが全角（漢字・ひらがな・カタカナ）でなければ登録できない' do
      @user.first_name = 'Taro'
      @user.valid?
      expect(@user.errors.full_messages).to include('First name is invalid. Input full-width characters.')
    end

    it 'last_nameが空では登録できない' do
      @user.last_name = ''
      @user.valid?
      expect(@user.errors.full_messages).to include("Last name can't be blank")
    end

    it 'last_nameが全角（漢字・ひらがな・カタカナ）でなければ登録できない' do
      @user.last_name = 'Yamada'
      @user.valid?
      expect(@user.errors.full_messages).to include('Last name is invalid. Input full-width characters.')
    end

    it 'first_name_kanaが空では登録できない' do
      @user.first_name_kana = ''
      @user.valid?
      expect(@user.errors.full_messages).to include("First name kana can't be blank")
    end

    it 'first_name_kanaが全角カタカナでなければ登録できない' do
      @user.first_name_kana = 'たろう'
      @user.valid?
      expect(@user.errors.full_messages).to include('First name kana is invalid. Input full-width katakana characters.')
    end

    it 'last_name_kanaが空では登録できない' do
      @user.last_name_kana = ''
      @user.valid?
      expect(@user.errors.full_messages).to include("Last name kana can't be blank")
    end

    it 'last_name_kanaが全角カタカナでなければ登録できない' do
      @user.last_name_kana = 'やまだ'
      @user.valid?
      expect(@user.errors.full_messages).to include('Last name kana is invalid. Input full-width katakana characters.')
    end

    it 'date_of_birthが空では登録できない' do
      @user.date_of_birth = ''
      @user.valid?
      expect(@user.errors.full_messages).to include("Date of birth can't be blank")
    end

    it 'パスワードが英字のみの場合は無効である' do
      @user.password = 'password'
      @user.password_confirmation = 'password'
      expect(@user).not_to be_valid
      expect(@user.errors[:password]).to include('must include both letters and numbers.')
    end

    it 'パスワードが数字のみの場合は無効である' do
      @user.password = '12345678'
      @user.password_confirmation = '12345678'
      expect(@user).not_to be_valid
      expect(@user.errors[:password]).to include('must include both letters and numbers.')
    end

    it 'パスワードに英字と数字が含まれていない場合は無効である' do
      @user.password = '!!!!!!!!'
      @user.password_confirmation = '!!!!!!!!'
      expect(@user).not_to be_valid
      expect(@user.errors[:password]).to include('must include both letters and numbers.')
    end
  end
end
