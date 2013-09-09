require 'test_helper'

class UserMailerTest < ActionMailer::TestCase
  test "password_reset" do

    mail = users(:bob).send_password_reset
    assert_equal "Mettre à jour votre mot de passe", mail.subject
    assert_equal [users(:bob).email], mail.to
    assert_equal ["voixvisuelle@gmail.com"], mail.from
    assert_match "Pour mettre à jour votre mot de passe cliquer le lien ci-dessous.", mail.body.encoded
  end

end
