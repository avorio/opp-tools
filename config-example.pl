
# Database connection:
MYSQL_DB   => 'database',
MYSQL_USER => 'user',
MYSQL_PASS => 'pass',

# Installation root (typically where this file lives):
PATH       => '/home/wo/projects/opp-tools/',

# Process papers with these filetypes:
FILETYPES  => ['pdf', 'ps', 'doc', 'rtf', 'html', 'txt'],

# Support OCR processing of PDFs:
OCR        => 1,

# Number of links to process in one go:
NUM_URLS   => 1,

# SOFTWARE
PS2PDF     => '/usr/bin/ps2pdf',
ANTIWORD   => '/usr/bin/antiword',