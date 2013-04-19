Dir.glob("tests/*.test").each do |test_file|
  result_file = test_file.gsub(/test$/, 'result')
  results = `cat \"#{test_file}\" | ./a.out`
  expected_results = File.read(result_file)
  if results != expected_results
    puts "FAILED on %s" % test_file
  else
    puts "PASSED on %s" % test_file
  end
end