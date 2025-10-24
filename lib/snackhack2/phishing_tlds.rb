# frozen_string_literal: true

module Snackhack2
    class PhishingData
    def domains
        [
           ".com",
           ".co",
           ".us",
           ".net",
           ".org",
           ".help",
           ".app",
           ".blog",
           ".info",
           ".biz",
           ".store",
           ".shop",
           ".tech",
           ".tv",
           ".photos",
           ".fitness",
           ".fun",
           ".space",
           ".solutions",
           ".email",
           ".studio",
           ".top",
           ".land",
           ".live",
           ".me",
           ".website",
           ".design",
           ".digital",
           ".world",
           ".gifts",
           ".love",
           ".art",
           ".holiday",
           ".london",
           ".tokyo", 
           ".tips", 
           ".rocks",
           ".work"
        ]
    end
    def domain_keywords
      [
        "connect",
        "corp",
        "duo",
        "help",
        "he1p",
        "helpdesk",
        "helpnow",
        "info",
        "internal",
        "mfa",
        "my",
        "okta",
        "onelogin",
        "schedule",
        "service",
        "servicedesk",
        "servicenow",
        "rci",
        "rsa",
        "sso",
        "ssp",
        "support",
        "usa",
        "vpn",
        "work",
        "dev",
        "workspace",
        "it",
        "ops",
        "hr",
        "login",
        "secure"
      ]
    end
  private :domains
end
class PhishingTlds < PhishingData
  attr_reader :site
  def initialize
      @site = site
  end
  def domain_split
    # This method splits up the value block_given
    # given in @site by the period. Which is used
    # by 'remove_tlds' method to remove the TLDs
     @site.split(".")
  end
  def site=(s)
      @site = s
  end
  def remove_tlds
    # this method function is to remove
    # the TLDs from the @site. For Example
    # it will remove .org, .com 
    
    ds = domain_split
    
    # remove ".com" (last element in array)
    ds.pop
    
    # returns the domain w/o the tlds
    ds
  end
  def check_domains(array: true)
    # The function of this method is to
    # check if the given domains are valid or not. 
    # By valid I mean resolvable and active. 
    
    
    # if domains is set to true, this array will hold the domains 
    domains_out = []
    
    # build the list of domains
    generated_tlds = change_tld
    
    valid_domains = []
    not_valid_domains = []
    
    generated_tlds.each do |domain|
      # if array is true; add the domains to array
      if array
        domains_out << domain
      else
        # if array is false print out the domains
        puts domain
      end
      domains_out if array
    end
  end
  def remove_letters(array_out: true)
    # This method will remove letters that 
    # occur more than once. For example:
    # google.com would become goggle.com
    
    # store the letter count in a hash. 
    letter_count = {}
    
    ds = remove_tlds
    
    # Creates an array with each character being
    # stored in a element. It will loop through the array 
    # and figure out the number of occurrences for each character
    ds.shift.split(//).each do |letter|
      if letter_count.has_key?(letter)
          letter_count[letter] += 1
      else
          letter_count[letter] = 1
      end
    end
    
    # After it creates the hash with the character and 
    # the number of time it cocures. This method 
    # will loop through the hash and check to see
    # if the value is greater than 1. If it is then the key ( the letter)
    # is added to the array named 'letters_with_more_than_one'
    letters_with_more_than_one = []
    letter_count.each do |key, value|
      if value > 1
          letters_with_more_than_one << key
      end
    end
    
    
    ds = remove_tlds
    new_ds = ds.shift
    
    # the final array with the duplicates letters removed
    remove_letters_out = []
    
    # Loops through the 'letters_with_more_than_one'
    # array and uses 'sub' to remove the occurence
    # of one of the letters
    letters_with_more_than_one.each do |l|
        # removes only first character ( l )
        remove_letters_out <<  new_ds.sub(l, "")
        # removes ALL chracters ( l )
        remove_letters_out <<  new_ds.gsub(l, "")
    end
    # add tldds to the created list
    domains_with_tlds = add_tlds(remove_letters_out)
    if array_out
        domains_with_tlds
    else
       # will print the contents of the array
       # instead of returning the array
       domains_with_tlds.each  { |a| puts a }
    end
  end
  def add_tlds(list)
    # takes the newly created domains (list)
    # and adds the tlds (domains) to the newly created
    # ones. 
    o = []
    list.each do |rr|
      domains.each do |dd|
        o << "#{rr}#{dd}"
      end
    end
  o
  end
  def combosquatting
    # where the generated domains will be located.
    results = []
    
    # get the domain_keywords array from the PhishingData class.
    keywords = domain_keywords
    
    prefixes = ["-", ".", "--"]
    ds = remove_tlds
    # this will generate the 'new_domain' with the keywords
    # as a prefix
    prefixes.each do |pre|
      ds.each do |domain|
        keywords.each do |key|
          new_domain = "#{key}#{pre}#{domain}"
          results << new_domain
        end
      end
    end
    suffixes = ["-", ".", "--"]
    # this will generate the 'new_domain' with the keywords
    # as a suffixes
    suffixes.each do |suf|
      ds.each do |domain|
        keywords.each do |key|
          new_domain = "#{domain}#{suf}#{key}"
          results << new_domain
        end
      end
    end
  # adds the tlds to the newly created domains
  add_tlds(results)
  end
  def change_tld(no_tld: true)
    # This method will take the inputted site in @site and 
    # remove the TLDs and add a new TLDs to the domain. 
    # its uses the 'domain' method in the PhishingData class
    # which has an array of a bunch of different tlds. 
    
  
    # if the @site does not have a tlds
    if no_tld
      new_domains = []
      # loop through the tlds
      domains.each do |d|
        # combine the inputed @site
        # and the tlds 
        new_domains << "#{@site}#{d}"
      end
      new_domains
    else
      # If the @site does have a TLDs.
      
      # this is where the final results
      # are stored. 
      list_of_domains = []
      
      # removes .com, .org, etc
      ds = remove_tlds
    
      # join the elements together with .
      ds = ds.join(".")
      
      # loops through the tlds
      domains.each do |tlds|
          # adds the new domains to the array
          list_of_domains << "#{ds}#{tlds}" 
          #ds + tlds
      end
    list_of_domains
    end
  end
  def idn_homograph 
    letters = {
      "o" => ["0", "О", "ó", "о","ο","օ","ȯ","ọ","ỏ","ơ","ó","ö"],
      "i" => ["1","ı", "ỉ", "і", "í", "ï"],
      "a" => ["а","α", "ạ"],
      "h" => ["н", "һ", "ĥ"], 
      "c" => ["с"],
      "I" => "l",
      "e" => ["е", "℮", "ё", "ė", "ẹ"],
      "b" => [ "þ", "в", "B" ],
      "g" => [ "ɢ"],
      "l" => ["Ɩ", "Ι"],
      "m" => ["m", "ʍ", "м"],
      "t" => ["т", "ţ"],
      "p" => ["р"],
      "y" => ["у", "ý"],
      "k" => ["ķ"],
      "d" => ["ɗ"],
      "z" => ["ź","ʐ", "ż"],
      "s" => ["ś", "ṣ"],
      "u" => ["ų", "υ", "ս","ü","ú","ù"],
      "n" => ["ń", "ñ"],
      "r" => ["ɾ", "R", "r", "ʀ", "Ի", "Ꮢ", "ᚱ", "Ｒ", "ｒ"],
      "ll" => ["ǁ"],
      "q" => ["զ"],
      "j" => ["ј", "ʝ"],
      "v" => ["ν", "ѵ"],
      "x" => ["х" "ҳ"]
    }
    tlds = @site.split(".")
    # removes the tlds
    tlds.pop
    # joins back the rest of the site
    tlds = tlds.join(".")

    new_domains = []
    letters.each do |k, v|
      tlds.split(//).each do |letter|
        # if the letter elements
        # are qual to the key vlaue 
        # located in the letters hash
        if letter.eql?(k)
          # find the key and replace it 
          # the v ( idn )
          if v.kind_of?(Array)
            # detct if the v ( value ) 
            # is an array. If it is 
            # then it will "randomly" pick an element
            v = v.sample
          end
          new_domains <<  tlds.gsub(k, v)                                                                                          
        end
      end
    end
=begin
    domains_with_tlds = []
    new_domains.each do |nd|
      domains.each do |d|
        domains_with_tlds << "#{nd}#{d}"
      end
    end
  domains_with_tlds
=end
  add_tlds(new_domains)
  end
  private :remove_tlds, :domain_split
  end
end