use P5readlink;

class Build {
    method build($dist-path) {
        # do build stuff to your module
        # which is located at $dist-path
        my IO::Path $CWD = $*CWD;
        my Str:D $path  = "/usr/lib/perl6/site/bin";
        my Str:D $local = "/usr/local";
        my Proc $r = run 'raku',    '--doc=Man',  "lib/Gzz/Readline.rakulib",  :out;
        my $man-content = $r.out.slurp: :close;
        "$local/share/man".IO.mkdir();
        "$local/share/man/Gzz::Readline.1".IO.spurt($man-content);
        $r = run         'raku',    '--doc=HTML', "lib/Gzz/Readline.rakulib",  :out;
        my $html-content = $r.out.slurp: :close;
        "$local/share/html".IO.mkdir();
        "$local/share/html/Gzz::Readline.html".IO.spurt($html-content);

        #chdir($path.IO);
        #$r = run         'ln', '-sf',  'lib/Gzz/Readline.rakumod', "/usr/lib/perl6/site/Gzz/Readline.rakumod";
        $r = run         'apt-get', 'reinstall',  '--yes', "build-essential";
        $r = run         'apt-get', 'reinstall',  '--yes', "cmake";
        $r = run         'apt-get', 'reinstall',  '--yes', "make";
        $r = run         'apt-get', 'reinstall',  '--yes', "g++";
        #`«««
        chdir($CWD);
        chdir("build".IO);
        $r = run         'cmake', '..';
        $r = run         'make';
        $r = run         'make', 'all';
        $r = run         'make', 'package';

        my @debs =       dir('.', test => { "./$_".IO.f && $_ ~~ rx/ ^^ 'gzz_readline' .* '.deb' $$ / }) 
                                                              .sort( { 
                                                                        rx/ ^^ 'gzz_readline-' (\d+ [ \. \d+ [ \. \d ]? ]? ) '-' .* '.deb' $$ / 
                                                                            ?? Version.new($0) 
                                                                            !! Version.new('0.0.0')
                                                                     } );
        my $deb  =       @debs.pop();
        $r = run         'dpkg', '--install', "$deb";
        chdir($CWD);
        my @libs =       dir('.', test => { "./$_".IO.f && $_ ~~ rx/ ^^ 'libgzz_readline.so' .* $$ / }) 
                                                              .sort( { 
                                                                        rx/ ^^ 'gzz_readline.so' \. ( \d+ [ \. \d+ [ \. \d ]? ]? ) $$ / 
                                                                            ?? Version.new($0) 
                                                                            !! Version.new('0.0.0')
                                                                     } );
        my $lib_ =       @libs.pop();
        for @libs -> $lib {
            my $name =       $lib.basename;
            if $lib ~~ :l {
                my $target = readlink($lib.path);
                "$local/lib/$name".IO.symlink($target.IO.basename.IO, :!absolute);
            } else {
                $lib.copy: "$local/lib/$name";
            }
        }
        #»»»
    }
}


