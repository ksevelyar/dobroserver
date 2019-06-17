# frozen_string_literal: true

module Translit
  TABLE = { 'μ' => 'micro',
            'а' => 'a',
            'б' => 'b',
            'в' => 'v',
            'г' => 'g',
            'д' => 'd',
            'е' => 'e',
            'ё' => 'yo',
            'ж' => 'zh',
            'з' => 'z',
            'и' => 'i',
            'й' => 'y',
            'к' => 'k',
            'л' => 'l',
            'м' => 'm',
            'н' => 'n',
            'о' => 'o',
            'п' => 'p',
            'р' => 'r',
            'с' => 's',
            'т' => 't',
            'у' => 'u',
            'ф' => 'f',
            'х' => 'h',
            'ц' => 'ts',
            'ч' => 'ch',
            'ш' => 'sh',
            'щ' => 'sch',
            'ъ' => '',
            'ы' => 'yi',
            'ь' => '',
            'э' => 'e',
            'ю' => 'yu',
            'я' => 'ya' }.freeze

  def self.slug(string)
    string = string.mb_chars.downcase

    TABLE.each do |translation|
      string.gsub!(/#{translation[0]}/, translation[1])
    end

    string.parameterize
  end
end
