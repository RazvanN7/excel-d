/**
   To avoid cyclic dependencies with module constructors
 */

module xlld.static_;

///
shared static this() {
    import xlld.xlcall: XLOPER12;
    import xlld.test_util: gAsyncReturns, AA;
    gAsyncReturns = AA!(XLOPER12, XLOPER12).create;
}


///
static this() {
    import xlld.test_util: excel12UnitTest;
    import xlld.xlcallcpp: SetExcel12EntryPt;
    // this effectively "implements" the Excel12v function
    // so that the code can be unit tested without needing to link
    // with the Excel SDK
    SetExcel12EntryPt(&excel12UnitTest);
}

///
static ~this() {
    import xlld.test_util: gCoerced, gFreed, gNumXlCoerce, gNumXlFree;
    import unit_threaded.should: shouldBeSameSetAs;
    gCoerced[0 .. gNumXlCoerce].shouldBeSameSetAs(gFreed[0 .. gNumXlFree]);
}