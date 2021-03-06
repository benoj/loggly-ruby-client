require 'json'

module LogglyRubyClient
  class CLI
    class Search

      def search
        opts = read_options
        s = LogglyRubyClient::Search.new :domain   => opts[:domain],
                                         :username => opts[:username],
                                         :password => opts[:password],
                                         :account  => opts[:account]

        result = s.search :input => opts[:input],
                          :from  => opts[:from],
                          :until => opts[:until],
                          :query => opts[:query],
                          :rows  => opts[:rows]

        if result["code"] == "200"
          jj result["body"]
        else
          puts "Error: #{result["error"]}"
          exit 1
        end
      end

      def read_options
        Trollop::options do
          version LogglyRubyClient::VERSION
          banner <<-EOS

Search Loggly

Usage:

loggly-ruby-client search -a account -q query

EOS
          opt :help, "Display Help"
          opt :account, "Read domain, username and password from account in ~/.loggly-ruby-client.yml", :type    => :string,
                                     :default => 'default'
          opt :domain, "Loggly Account Domain", :type => :string
          opt :from, "From Date", :type    => :string,
                                  :default => 'NOW-1HOUR'
          opt :input, "Input To Search", :type  => :string,
                                         :multi => true
          opt :until, "Until Date", :type  => :string,
                                    :short => :none
          opt :query, "Query (multiple will be joined with AND)", :type  => :string,
                                                                  :multi => true
          opt :password, "Loggly Password", :type => :string
          opt :rows, "Rows To Return", :type => :string
          opt :username, "Loggly Username", :type => :string
        end
      end
 
    end
  end
end
