public class ByteSizeTest {
    @Test
    public void testParse() {
        assertEquals(1024L, new ByteSize("1KB").getBytes());
        assertEquals(1024L * 1024, new ByteSize("1MB").getBytes());
        // Add more test cases for different units
    }
}
