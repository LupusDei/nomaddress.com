require 'openssl'

module UserSafe

  def self.generate_pair(password)
    private_key = OpenSSL::PKey::RSA.generate(2048).to_s
    pair = OpenSSL::PKey::RSA.new(private_key)

    public_key = pair.public_key.to_s

    encrypted_private_key = encrypt_private_key(public_key, private_key, password)
    [public_key, encrypted_private_key]
  end

  def self.encrypt(data, public_key)
    encryptifier = OpenSSL::PKey::RSA.new(public_key)
    encryptifier.public_encrypt(data)
  end

  def self.decrypt(encrypted_data, public_key, encrypted_private_key, password)
    private_key = decrypt_private_key(public_key, encrypted_private_key, password)
    decryptifier = OpenSSL::PKey::RSA.new(private_key)
    decryptifier.private_decrypt(encrypted_data)
  end


  private

  def self.encrypt_private_key(public_key, private_key, password)
    key = to_256_key(password)
    cipher = OpenSSL::Cipher::Cipher.new('aes-256-cbc')
    cipher.encrypt 
    cipher.key = key
    cipher.iv = public_key

    cipher.update(private_key) + cipher.final
  end

  def self.decrypt_private_key(public_key, encrypted_private_key, password)
    key = to_256_key(password)
    cipher = OpenSSL::Cipher::Cipher.new('aes-256-cbc')
    cipher.decrypt 
    cipher.key = key
    cipher.iv = public_key

    cipher.update(encrypted_private_key) + cipher.final
  end

  def self.to_256_key(short_key)
    key = short_key
    while key.size < 256
      key += short_key
    end
    key[0..256]
  end

end
