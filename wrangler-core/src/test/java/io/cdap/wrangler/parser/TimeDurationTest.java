public class TimeDurationTest {
    @Test
    public void testParse() {
        assertEquals(1000000L, new TimeDuration("1ms").getNanos());
        assertEquals(1000000000L, new TimeDuration("1s").getNanos());
        // Add more test cases for different units
    }

}
