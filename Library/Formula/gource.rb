require 'formula'

class Gource <Formula
  homepage 'http://code.google.com/p/gource/'
  url 'git://github.com/acaudwell/Gource.git', :tag => "f07d59f582a29bca55da"
  version "0.32"
  head 'git://github.com/acaudwell/Gource.git'

  depends_on 'pkg-config' => :build
  depends_on 'sdl'
  depends_on 'sdl_image'
  depends_on 'ftgl'
  depends_on 'jpeg'
  depends_on 'libpng'
  depends_on 'pcre'
  depends_on 'glew'

  def install
    ENV.x11 # Put freetype-config in path

    # For non-/usr/local installs
    ENV.append "CXXFLAGS", "-I#{HOMEBREW_PREFIX}/include"

    system "autoreconf -f -i" unless File.exist? "configure"

    system "./configure", "--disable-dependency-tracking",
                          "--prefix=#{prefix}",
                          "--disable-sdltest",
                          "--disable-freetypetest"
    system "make install"
  end

  def test
    Dir.chdir HOMEBREW_REPOSITORY do
      system "gource"
    end
  end
end
