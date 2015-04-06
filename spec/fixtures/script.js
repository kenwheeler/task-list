// TODO: Test Comment
// FIXME :Test Comment 2
// TODO:Test Comment 3
// TODO : Test Comment 4
// TODO				:	Test Comment 5
// TODO - Test Comment 6
// FIXME-Test Comment 7
// TODO    -   Test Comment 8
// TODO Test Comment 9
// TODO       Test Comment 10
// before TODO: Test Comment 11
/*
TODO: block comment
*/
var map { // TODO task at end of line
TO_DO: "not a comment", // FIX-ME: this example (and the one following it) fail in the sense that when you reomve the underscore they are parsed as to do items
FIX_ME : "still not a comment"
}
var str = "// TO DO in a string"; // this also fails
/*
TODO: block comment line 1
TODO: block comment line 2
*/
