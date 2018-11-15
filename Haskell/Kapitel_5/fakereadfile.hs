fakeReadFile :: FilePath -> IO String
fakeReadFile x = do 
    return ("FakeReadFile obviously didnt read anything but it pretends to read this string from the file " ++ x ++ ".")