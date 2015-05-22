use strict;
use warnings;
use utf8;
use Test::More;
use Test::Ika;

Test::Ika->set_reporters('Test');
my @RESULT;
{
    package sandbox;
    use Test::Ika;
    use Test::More;

    describe 'foo' => sub {
        before_all {
            push @RESULT, 'BEFORE ALL foo';
        };
        after_all {
            push @RESULT, 'AFTER ALL foo';
        };
        before_each {
            push @RESULT, 'BEFORE EACH foo';
        };
        after_each {
            push @RESULT, 'AFTER EACH foo';
        };
        it p => sub {
            push @RESULT, 'test p';
        };
    };

    describe 'x' => sub {
        before_all {
            push @RESULT,  'BEFORE ALL x';
        };
        after_all {
            push @RESULT,  'AFTER ALL x';
        };
        it y => sub {
            push @RESULT, 'test y';
        };
        it z => sub {
            push @RESULT, 'test z';
        };
    };

    before_suite {
        push @RESULT, 'BEFORE SUITE';
    };
    after_suite {
        push @RESULT, 'AFTER SUITE';
    };

    runtests;
}
is(join("\n", @RESULT), join("\n", (
'BEFORE SUITE',
    'BEFORE ALL foo',
        'BEFORE EACH foo',
            'test p',
        'AFTER EACH foo',
    'AFTER ALL foo',

    'BEFORE ALL x',
        'test y',
        'test z',
    'AFTER ALL x',
'AFTER SUITE',
)));

done_testing;

