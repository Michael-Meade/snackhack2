# frozen_string_literal: true

module Snackhack2
  class PhishingDomains
    attr_reader :site
    def initialize
        @site = site
    end
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
    def site=(site)
        @site = site
    end
    def domain_split
       @site.split(".")
    end
    def check_domains(array: true)
        # if domains is set to true, this array will hold the domains 
        domains_out = []
        # build the list of domains
        generated_tlds = change_tld
        
        
        valid_domains = []
        not_valid_domains = []
        
        generated_tlds.each do |domain|
            if array
                domains_out << domain
            else
                puts domain
            end
            domains_out if array
        end
    end
    def change_tld
        # this is the final result
        list_of_domains = []
        
        # gets the array of tlds
        ds = domain_split
        
        # removes the last element of the array ( the tlds )
        ds.pop
        
        # join the two elements together
        ds = ds.join(".")
        
        
        # loops through the tlds
        domains.each do |tlds|
            # adds it to the array
            list_of_domains <<  ds + tlds
        end
    list_of_domains
    end
    private :change_tld
  end
  class Snackhack2::ChangeLetters
     attr_reader :site
    def initialize
        @site = site
    end
    def site=(site)
        @site = site
    end
    def domain_split
        @site.split(".")
    end
    def similar_letters
        list_of_domains = []
        
        # gets the array of tlds
        ds = domain_split
        
        ds.pop
        
        # join the two elements together
        ds = ds.join(".")
        
        letters = {"o" => "O", 
        "i" => "l",
        "m" => [ "nn", "rn" ],
        }

        letters.each do |key, value|
            if !value.kind_of?(Array)
                tlds = domain_split.last
                new_domain = ds.gsub(key, value)
                list_of_domains << new_domain + "." + tlds
            end
        end
    list_of_domains
    end
  end
end