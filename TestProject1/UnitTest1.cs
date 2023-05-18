using SampleWebApp;
using System;
using Xunit;

namespace TestProject1
{
    public class UnitTest1
    {
        [Theory]
        [InlineData(4, 3, 7)]
        [InlineData(1, 1, 2)]
        [InlineData(12, 13, 125)]

        public void Test1(int a, int b, int output)
        {
            double actual = new Calculation().Add(a, b);
            Assert.Equal(output, actual);
        }
    }
}
