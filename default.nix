{ stdenv, fetchurl, libdvdread, intltool, glib, libtool, pkgconfig }:

stdenv.mkDerivation rec {

  version = "0.4.2";
  name = "dvdbackup-${version}";

  src = fetchurl {
    url = "https://sourceforge.net/projects/dvdbackup/files/dvdbackup/dvdbackup-${version}/dvdbackup-${version}.tar.xz";
    sha256 = "1rl3h7waqja8blmbpmwy01q9fgr5r0c32b8dy3pbf59bp3xmd37g";
  };

  buildInputs = [
    libdvdread intltool glib libtool pkgconfig
  ];

  meta = with stdenv.lib; {
    homepage = http://dvdbackup.sourceforge.net/;
    description = "A tool to rip video DVDs from the command line";
    license = licenses.gpl3;
    maintainers = [ "Neil Mayhew <neil_mayhew@users.sourceforge.net" ];
    platforms = platforms.linux;
  };
}
