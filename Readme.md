## Slim Convertable Webservice

Convert you Slim templates into HTML. 

```ruby
slim_source = File.open(path_to_slim).read

result = RestClient.post "http://slim-convert.herokuapp.com/v1/slim/convert", :source => slim_source
encoded = MultiJson.load(result)

p encoded["result"]
```


