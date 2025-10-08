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
        remove_lettters_out = []
        
        # Loops through the 'letters_with_more_than_one'
        # array and uses 'sub' to remove the occurence
        # of one of the letters
        letters_with_more_than_one.each do |l|
            remove_lettters_out <<  new_ds.sub(l, "")
        end
        
        if array_out
            remove_lettters_out
        else
           # will print the contents of the array
           # instead of returning the array
           remove_lettters_out.each  { |a| puts a }
        end
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
        
          # join the elements together
          ds = ds.join(".")
          
          # loops through the tlds
          domains.each do |tlds|
              # adds the new domains to the array
              list_of_domains <<  ds + tlds
          end
        list_of_domains
        end
      end
      private :remove_tlds, :domain_split
    end
end