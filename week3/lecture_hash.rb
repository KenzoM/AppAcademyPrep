require 'active_support/all'
def brittle_format_url(scheme, host, path, query_hash)
  # a hash to a query string.
  query_string = query_hash.to_query
  "#{ scheme }://#{ host }/#{ path }?#{ query_string }"
end

# have to remember to supply arguments in order. boo.
p brittle_format_url(
  "http",
  "www.google.com",
  "search",
  { search_query: "mitt romney, how many sons?" }
)
# => "http://www.google.com/search?search_query=mitt+romney%2C+how+many+sons%3F"
def better_format_url(options = {})
  defaults = {
    scheme: "http",
    path: "/",
    query_hash: {}
  }

  # this is not modifying the original options hash
  # that was passed in, but rather creating a new hash
  # and assigning it to `options`
  options = defaults.merge(options)

  query_string = options[:query_hash].to_query

  "#{ options[:scheme] }://#{ options[:host] }/#{ options[:path] }?#{ query_string }"
end

p better_format_url({
  scheme: "http",
  host: "www.google.com",
  path: "search",
  query_hash: {
    search_query: "mitt romney, how many sons?"
  }
})
#=> "http://www.google.com/search?search_query=mitt+romney%2C+how+many+sons%3F"

# rely on defaults for scheme ("http"), path ("/"), query_hash ({})
p better_format_url({ host: "www.nytimes.com" })
#=> "http://www.nytimes.com/?"
