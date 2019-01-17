using System;
using System.Collections.Generic;
using System.Text;
using System.Text.RegularExpressions;

namespace DKClassLibrary
{
    public static class DKValidations
    {
        public static string DKCapitalize(string input)
        {
            if (input == null || input.Trim() == "")
            {
                return "";
            }
            else
            {
                input = input.Trim().ToLower();
                string output = "";
                string[] inputArray = input.Split(' ');

                for (int i = 0; i < inputArray.Length; i++)
                {
                    if (i < inputArray.Length - 1)
                    {
                        output += inputArray[i].Substring(0, 1).ToUpper() + inputArray[i].Substring(1) + " "; 
                    }
                    else
                    {
                        output += inputArray[i].Substring(0, 1).ToUpper() + inputArray[i].Substring(1);
                    }
                }
                return output;
            }
        }

        public static string DKExtractDigits(string input)
        {
            string digits = "";
            char[] inputArray = input.ToCharArray();
            foreach (char ch in inputArray)
            {
                if (char.IsDigit(ch))
                {
                    digits += ch.ToString();
                }
            }
            return digits;
        }

        // for Canada postal code
        public static bool DKPostalCodeValidation(string input)
        {
            if (input == null || input == "")
            {
                return true;
            }
            else if (input.Trim() == "")
            {
                return false;
            }
            else
            {
                input = input.ToUpper().Trim();
                // Canadian postal codes can't contain the letters D, F, I, O, Q, or U, and cannot start with W or Z
                string regExp = @"^[ABCEGHJKLMNPRSTVXY]\d[ABCEGHJKLMNPRSTVWXYZ] ?\d[ABCEGHJKLMNPRSTVWXYZ]\d$";
                if (Regex.IsMatch(input, regExp))
                {
                    return true;
                }
                else
                {
                    return false;
                }
            }
        }

        public static string DKPostalCodeFormat(string input)
        {
            if (!DKPostalCodeValidation(input))
            {
                return null;
            }
            else if (input == "" || input == null)
            {
                return null;
            }
            string output = "";
            char[] charArray = input.ToCharArray();
            foreach (char ch in charArray)
            {
                output += ch.ToString().ToUpper();
            }

            output = output.Insert(3, " ");

            return output;
        }

        // for US zip code
        public static bool DKZipCodeValidation(ref string input)
        {
            if (input == null || input.Trim() == "")
            {
                input = "";
                return true;
            }

            string digits = DKExtractDigits(input);
            if (digits.Length == 5)
            {
                input = digits;
                return true;
            }
            else if (digits.Length == 9)
            {
                input = digits.Insert(5, "-");
                return true;
            }
            else
            {
                return false;
            }
        }
    }
}
