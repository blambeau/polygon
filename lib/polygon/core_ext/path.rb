class Path

  register_loader '.rb', '.ruby' do |path|
    ::Kernel.eval(path.read, TOPLEVEL_BINDING, path.to_s)
  end

  register_loader '.md' do |path|
    require 'yaml'
    content = path.read
    if content =~ /^(---\s*\n.*?\n?)^(---\s*$\n?)/m
      (YAML::load($1) || {}).merge("content" => $')
    else
      {"content" => content}
    end
  end

  def to_url
    path = self.rm_ext
    path = path.dir if path.basename.to_s == 'index'
    path = path == Path('.') ? Path("") : path
    path.to_s
  end

end
