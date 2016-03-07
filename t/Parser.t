use strict;
use warnings;
use utf8;
use Test::More;
use Plantuml::Parser;
use t::Util qw/load_fixture/;

BEGIN { use_ok 'Plantuml::Parser' };

my $fixture = load_fixture('all.pu');

subtest "_extract_class()" => sub {
    my $expect = +[
'class Main {
  run()
}',
'class Plantuml::Parser {
  classes
  relations
  parse()
  _extract_class_strings()
  _extract_relation_strings()
}',
'class Plantuml::Factory {
  create()
  _check_is_method()
  _check_is_variable()
}',
'class Plantuml::Class {
  attribute
  parents
  variables
  methods
  build()
}',
'class Plantuml::Variable {
  name
  attribute
  build()
}',
'class Plantuml::Method {
  name
  attribute
  build()
}',
'class Plantuml::Relation {
  from
  to
  name
  build()
}',
    ];
    is_deeply(Plantuml::Parser->_extract_class($fixture), $expect);
};

subtest "_extract_relation()" => sub {
    my $expect = +[
'Class *-- Variable',
'Class *-- Method',
'Class <-- Relation',
'Factory <-- Class',
'Factory ..|> Variable',
'Factory ..|> Method'
    ];
    is_deeply(Plantuml::Parser->_extract_relation($fixture), $expect);
};

done_testing;