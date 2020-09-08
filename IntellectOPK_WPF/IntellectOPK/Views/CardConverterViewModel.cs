using IntellectOPK.Commands;
using IntellectOPK.Utilities;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Input;

namespace IntellectOPK.Views
{
    public class CardConverterViewModel: ViewModelBase
    {
        #region Member Data

        private System.Windows.Window view;
        private string title;
        private uint fullNumber;
        private string hikvisionNumber;
        private uint facilityCod;
        private uint cardNumber;
        private const uint intMax24Bits = 16777216;
        private const uint intMax16Bits = 65536;
        private const uint intMax8Bits = 256;
        private const uint intMaxHik = 25665536; //srting 256 + string 65536 
        private const int maxCardNumberLength = 5; //Length of intMax16Bits
        #endregion


        #region Constructor
        public CardConverterViewModel(System.Windows.Window view)
        {
            this.view = view;
            this.title = "Конвертер карт";
       }

        #endregion


        #region Properties

        public string Title
        {
            get { return this.title; }
        }

        public string FullNumber
        {
            get { return this.fullNumber == 0 ? "" : this.fullNumber.ToString(); }
            set
            {
                if (value == "") value = "0";
                uint num;                
                if (uint.TryParse(value, out num))
                {
                    if (num <= intMax24Bits)
                    {
                        this.fullNumber = num;                                              
                    }
                }                
                riseOnPropertyChanged();
            }
        }        

        public string FacilityCod
        {
            get { return this.facilityCod == 0 ? "" : this.facilityCod.ToString(); }
            set
            {
                if (value == "") value = "0";
                uint num;
                if (uint.TryParse(value, out num))
                {
                    if (num <= intMax8Bits)
                    {
                        this.fullNumber = (num * intMax16Bits) +  this.cardNumber;                        
                    }
                }                
                riseOnPropertyChanged();
            }
        }

        public string CardNumber
        {
            get { return this.cardNumber == 0 ? "" : this.cardNumber.ToString(); }
            set
            {
                if (value == "") value = "0";
                uint num;
                if (uint.TryParse(value, out num))
                {
                    if (num <= intMax16Bits)
                    {
                        this.fullNumber = (this.facilityCod * intMax16Bits) + num;                        
                    }
                }
                riseOnPropertyChanged();
            }
        }
        public string HikvisionNumber
        {
            get { return this.hikvisionNumber; }
            set
            {
                if (value == "") value = "0";
                uint num;
                if (uint.TryParse(value, out num))
                {
                    if (num <= intMaxHik)
                    {
                        string first8bitString = "0";
                        string second16bitString = "0";
                        
                        if (value.Length > maxCardNumberLength)
                        {
                            first8bitString = value.Substring(0, value.Length - maxCardNumberLength);
                            second16bitString = value.Substring(value.Length - maxCardNumberLength);
                        }
                        else
                        {
                            second16bitString = value;
                        }

                        uint first8bit = Convert.ToUInt32(first8bitString);
                        uint second16bit = Convert.ToUInt32(second16bitString);
                        this.fullNumber = (first8bit * intMax16Bits) + second16bit;
                        
                    }
                }
                riseOnPropertyChanged();
            }
        }


        #endregion


        #region Protected Methods

        #endregion


        #region Commands


        #endregion


        #region Helper Methods


        private void riseOnPropertyChanged()
        {
            this.facilityCod = this.fullNumber / intMax16Bits;
            this.cardNumber = this.fullNumber % intMax16Bits;
            string facilityCodString = this.facilityCod == 0 ? "" : this.facilityCod.ToString();
            string cardNumberString = "";
            if(this.cardNumber > 0)
            {
                cardNumberString = ("00000" + this.cardNumber.ToString()).Substring(this.cardNumber.ToString().Length, maxCardNumberLength);
            }
            this.hikvisionNumber = facilityCodString + cardNumberString;

            this.OnPropertyChanged("FullNumber");
            this.OnPropertyChanged("FacilityCod");
            this.OnPropertyChanged("CardNumber");
            this.OnPropertyChanged("HikvisionNumber");
        }
        
        #endregion
    }
}
