use strict;
use warnings;
use ExtUtils::MakeMaker;

WriteMakefile(
    NAME                => 'Graph::Traversal::LexBFS',
    AUTHOR              => 'Jeffrey Burdges <burdges@gmail.com>',
    VERSION_FROM        => 'lib/Graph/Traversal/LexBFS.pm',
    ABSTRACT_FROM       => 'lib/Graph/Traversal/LexBFS.pm',
    ($ExtUtils::MakeMaker::VERSION >= 6.3002
      ? ('LICENSE'=> 'perl')
      : ()),
    PL_FILES            => {},
    PREREQ_PM => {
        'Test::More' => 0,
    },
    dist                => { COMPRESS => 'gzip -9f', SUFFIX => 'gz', },
    clean               => { FILES => 'Graph-Traversal-LexBFS-*' },
);
