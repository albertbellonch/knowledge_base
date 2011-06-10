class String
  def to_ascii
    Unicode.normalize_KD(self).unpack('U*').select{ |cp| cp < 127 }.pack('U*')
  end
end
