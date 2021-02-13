Gem::Specification.new do |spec|
  spec.name          = "csd3"
  spec.version       = "2.0.10"
  spec.authors       = ["saowang"]
  spec.email         = ["saowang@outlook.com"]

  spec.summary       = "A collection of CSD3 notes"
  spec.license       = "MIT"
  spec.homepage      = "https://cambridge-ceu.github.io/csd3/"

  spec.files         = `git ls-files -z`.split("\x0").select { |f| f.match(%r!^(assets|_layouts|_includes|_sass|LICENSE|README)!i) }

  spec.add_runtime_dependency "github-pages", "~> 209"
end
