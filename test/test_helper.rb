def file_fixture(name)
  JSON.parse(File.read("./test/fixtures/#{name}"))
end
