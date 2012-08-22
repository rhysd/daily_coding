envfile = Rails.root.join(".env")

if envfile.exist?
  envfile.open("r").each do |line|
    key, val = line.chomp.split("=", 2)
    ENV[key] = val
  end
end
