#! /usr/bin/perl -w
use strict;
use warnings;
use Test::More 'no_plan';
binmode STDOUT, ":utf8";
use utf8;
use lib '../..';
use Cwd 'abs_path';
use Converter;
use Extractor;
my %cfg = do 'config.pl';

my %tests = (

 '/home/wo/programming/opp-tools/test/doctests/11-Chalmers-probability.pdf' => {
   authors => ["David J. Chalmers"],
   title => "Probability and Propositions",
 },

 '/home/wo/programming/opp-tools/test/doctests/11-Byrne-Hayek-Hume.pdf' => {
   authors => ["Alex Byrne", "Alan Hájek"],
   title => "David Hume, David Lewis, and Decision Theory",
 },

 '/home/wo/programming/opp-tools/test/doctests/12-Avigad-Understanding.pdf' => {
   authors => ["Jeremy Avigad"],
   title => "Understanding, formal verification, and the philosophy of mathematics",
 },

 '/home/wo/programming/opp-tools/test/doctests/11-Rayo-Generality.pdf' => {
   authors => ["Agustín Rayo"],
   title => "Absolute Generality Reconsidered",
 },

 '/home/wo/programming/opp-tools/test/doctests/11-Skyrms-Game.pdf' => {
   authors => ["Brian Skyrms"],
   title => "Game Theory, Rationality and Evolution of the Social Contract",
 },

 '/home/wo/programming/opp-tools/test/doctests/11-Incurvati-Smith-Rejection.pdf' => {
   authors => ["Luca Incurvati", "Peter Smith"],
   title => "Rejection and valuations",
 },

 '/home/wo/programming/opp-tools/test/doctests/22-Kolodny-Myth.pdf' => {
   authors => ["Niko Kolodny"],
   title => "The Myth of Practical Consistency",
 },

 '/home/wo/programming/opp-tools/test/doctests/22-Newman-Wholes.pdf' => {
   authors => ["Andrew Newman"],
   title => "In Defence of Real Composite Wholes",
 },

 '/home/wo/programming/opp-tools/test/doctests/21-Polger-Shapiro-Understanding.pdf' => {
   authors => ["Thomas W. Polger", "Lawrence A. Shapiro"],
   title => "Understanding the Dimensions of Realization",
 },

 '/home/wo/programming/opp-tools/test/doctests/22-Roxborough-Cumby-Folk.pdf' => {
   authors => ["Craig Roxborough", "Jill Cumby"],
   title => "Folk Psychological Concepts: Causation",
 },

 '/home/wo/programming/opp-tools/test/doctests/22-Anon-Ramsey.pdf' => {
   authors => [""],
   title => "Two Interpretations of the Ramsey Test",
 },

 '/home/wo/programming/opp-tools/test/doctests/32-Potts-et-al-Expressives.pdf' => {
   authors => ["Christopher Potts", "Ash Asudeh", "Seth Cable", "Yurie Hara", "Eric McCready", "Martin Walkow", "Luis Alonso-Ovalle", "Rajesh Bhatt", "Christopher Davis", "Angelika Kratzer", "Tom Roeper"],
   title => "Expressives and identity conditions",
 },

 '/home/wo/programming/opp-tools/test/doctests/31-Seidenfeld-et-al-Preference.pdf' => {
   authors => ["Teddy Seidenfeld", "Mark J. Schervish", "Joseph B. Kadane"],
   title => "Preference for equivalent random variables: A price for unbounded utilities",
 },

 '/home/wo/programming/opp-tools/test/doctests/22-Fricker-Understanding.pdf' => {
   authors => ["Elizabeth Fricker"],
   title => "Understanding and Knowledge of What is Said",
 },

 '/home/wo/programming/opp-tools/test/doctests/B22-Fox-Lappin-Foundations.pdf' => {
   authors => ["Chris Fox", "Shalom Lappin"],
   title => "Foundations of Intensional Semantics",
 },

 '/home/wo/programming/opp-tools/test/doctests/31-Davies-Stoljar-Introduction.pdf' => {
   authors => ["Martin Davies", "Daniel Stoljar"],
   title => "Introduction",
 },

 '/home/wo/programming/opp-tools/test/doctests/32-Block-Functional.pdf' => {
   authors => ["Ned Block"],
   title => "Functional Reduction",
 },

 '/home/wo/programming/opp-tools/test/doctests/22-Anon-Aposteriori.pdf' => {
   authors => [""],
   title => "A Posteriori Identities and the Requirements of Rationality",
 },

 '/home/wo/programming/opp-tools/test/doctests/23-Byrne-et-al-See.pdf' => {
   authors => ["Alex Byrne", "David R. Hilbert", "Susanna Siegel"],
   title => "Do we see more than we can access?",
 },

 '/home/wo/programming/opp-tools/test/doctests/22-Block-Anna.pdf' => {
   authors => ["Ned Block"],
   title => "The Anna Karenina Theory of the Unconscious",
 },

 '/home/wo/programming/opp-tools/test/doctests/21-Anon-Qualia.pdf' => {
   authors => [""],
   title => "Qualia",
 },

 '/home/wo/programming/opp-tools/test/doctests/32-Cole-Nativism.doc' => {
   authors => ["David Cole"],
   title => "Cheap Nativism",
 },

 '/home/wo/programming/opp-tools/test/doctests/22-LeMorvan-Selfishness.pdf' => {
   authors => ["Pierre Le Morvan"],
   title => "Selfishness, Altruism, and Our Future Selves",
 },

 '/home/wo/programming/opp-tools/test/doctests/22-Carson-Bribery.pdf' => {
   authors => ["Thomas L. Carson"],
   title => "Bribery, Extortion, and \"The Foreign Corrupt Practices Act\"",
 },

 '/home/wo/programming/opp-tools/test/doctests/11-Heath-Ideology.pdf' => {
   authors => ["Joseph Heath"],
   title => "Ideology, Irrationality and Collectively Self-defeating Behavior",
 },

 '/home/wo/programming/opp-tools/test/doctests/32-Bittner-Hale-Remarks.pdf' => {
   authors => ["Maria Bittner", "Ken Hale"],
   title => "Remarks on Definiteness in Warlpiri",
 },

 '/home/wo/programming/opp-tools/test/doctests/22-Stampe-Reingold-Influence.pdf' => {
   authors => ["Dave M. Stampe", "Eyal M. Reingold"],
   title => "Inhuence of stimulus characteristics on the latency of saccadic inhibition",
 },

 '/home/wo/programming/opp-tools/test/doctests/21-Chaitin-Information.pdf' => {
   authors => ["Gregory J. Chaitin"],
   title => "Information- Theoretic Limitations of Formal Systems",
 },

 '/home/wo/programming/opp-tools/test/doctests/31-Pollock-Logic.pdf' => {
   authors => ["John L. Pollock"],
   title => "LOGIC: <i>An</i> INTRODUCTION <i>to the</i> FORMAL STUDY <i>of</i> REASONING",
 },

 '/home/wo/programming/opp-tools/test/doctests/222-Schollmeier-Ancient.pdf' => {
   authors => [""],
   title => "Ancient Tragedy and Other Selves",
 },

 '/home/wo/programming/opp-tools/test/doctests/33-Thomson-Philosophical.pdf' => {
   authors => ["Iain Thomson"],
   title => "The Philosophical Fugue: Understanding the Structure and Goal of Heidegger's <I>Beitr4ge</I>",
 },

 '/home/wo/programming/opp-tools/test/doctests/11-Bacon-Naive.pdf' => {
   authors => ["Andrew Bacon"],
   title => "A new conditional for naïve truth theory",
 },

 '/home/wo/programming/opp-tools/test/doctests/22-Latham-Token.doc' => {
   authors => ["Noa Latham"],
   title => "What is Token Physicalism?",
 },

 '/home/wo/programming/opp-tools/test/doctests/22-Anon-Interpretive.doc' => {
   authors => [""],
   title => "Hard Problems, Interpretive Concepts, and Humean Laws",
 },

 '/home/wo/programming/opp-tools/test/doctests/32-Galileo-Sopra.pdf' => {
   authors => [""],
   title => "Sopra le Scoperte Dei Dadi",
 },
 
 '/home/wo/programming/opp-tools/test/doctests/21-buchak-chance.pdf' => {
   authors => ["Lara Buchak"],
   title => "Free Acts and Chance: Why the Rollback Argument Fails", 
 },

 '/home/wo/programming/opp-tools/test/doctests/33-Johnson-Quantitative.pdf' => {
   authors => ["Kent Johnson"],
   title => "Quantitative realizations of philosophy of science: William Whewell and statistical methods",
 },

 '/home/wo/programming/opp-tools/test/doctests/21-Huber-Subjective.pdf' => {
   authors => ["Franz Huber"],
   title => "Subjective Probabilities as Basis for Scientific Reasoning?",
 },

 '/home/wo/programming/opp-tools/test/doctests/22-Kotzen-Review.pdf' => {
   authors => ["Matthew Kotzen"],
   title => "<i>Review of</i> <I><i>Decision Theory and Rationality</i> </I><i>by José Luis Bermúdez</i>",
 },

 '/home/wo/programming/opp-tools/test/doctests/22-Anonymous-Causation.pdf' => {
   authors => [""],
   title => "Causation and Freedom",
 },

 '/home/wo/programming/opp-tools/test/doctests/33-Sullivan-Tense.pdf' => {
   authors => ["Meghan Sullivan"],
   title => "Problems for Temporary Existence in Tense Logic",
 },

 '/home/wo/programming/opp-tools/test/doctests/32-black-avicienna.pdf' => {
   authors => ["Deborah L. Black"],
   title => "Avicenna’s “Vague Individual” and its Impact on Medieval Latin Philosophy",
 },

 '/home/wo/programming/opp-tools/test/doctests/32-Liao-Bias.pdf' => {
   authors => ["S. Matthew Liao"],
   title => "Bias and Reasoning: Haidt’s Theory of Moral Judgment",
 },

 '/home/wo/programming/opp-tools/test/doctests/22-Weatherson-Centrality.pdf' => {
   authors => ["Brian Weatherson"],
   title => "Centrality and Marginalisation",
 },

 '/home/wo/programming/opp-tools/test/doctests/33-Otsuka-Saving.pdf' => {
   authors => ["Michael Otsuka"],
   title => "Saving Lives, Moral Theory, and the Claims of Individuals",
 },

 '/home/wo/programming/opp-tools/test/doctests/22-Pasnau-Democritus.pdf' => {
   authors => ["Robert Pasnau"],
   title => "Democritus and Secondary Qualities",
 },

 '/home/wo/programming/opp-tools/test/doctests/32-List-Discursive.pdf' => {
   authors => ["Christian List"],
   title => "The Discursive Dilemma and Public Reason",
 },

 '/home/wo/programming/opp-tools/test/doctests/22-List-Emergent.pdf' => {
   authors => ["Christian List", "Marcus Pivato"],
   title => "Emergent Chance",
 },



);

sub proc {
    my $file = shift;
    convert2xml($file);
    my $extractor = Extractor->new("$file.xml");
    $extractor->extract(qw/authors title/);
    system("rm $file.xml");
    return ($extractor->{authors}, $extractor->{title});
}

while (my ($file, $res) = each(%tests)) {
    print substr($file, length('/home/wo/programming/opp-tools/test/doctests/')), "\n";
    my ($au, $ti); 
    eval {
        ($au, $ti) = proc($file);
    };
    next if ($@);
    is(join(", ", @$au), join(", ", @{$res->{authors}}));
    is($ti, $res->{title});
}
