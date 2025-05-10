package io.cdap.wrangler.parser;

import org.junit.Test;
import static org.junit.Assert.*;

public class ByteSizeTest {
    @Test
    public void testParse() {
        assertEquals(1024L, new ByteSize("1KB").getBytes());
        assertEquals(1024L * 1024, new ByteSize("1MB").getBytes());
        assertEquals(1024L * 1024 * 1024, new ByteSize("1GB").getBytes());
        assertEquals(512L, new ByteSize("512B").getBytes());
        // Add more test cases as needed
    }
}
