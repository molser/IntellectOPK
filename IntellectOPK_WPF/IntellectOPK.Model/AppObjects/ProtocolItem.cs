using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace IntellectOPK.Model
{
    public class ProtocolItem
    {
        public DateTime Date  {get; set;}
        public string Event { get; set; }
        public string Nc32kName { get; set; }
        public string Information { get; set; }
        public string Department { get; set; }

        public string Nc32kId { get; set; }
        

        public int PersonKey { get; set; }
        public string PersonID { get; set; }

        public string Card { get; set; }

        public ProtocolItem()
        {
            
        }
        public ProtocolItem(DateTime date, 
                                string app_event, 
                                string information, 
                                string department,
                                string nc32kId,
                                string nc32kName,
                                int personKey,
                                string personId, 
                                string card)
        {
            this.Date = date;
            this.Event = app_event;
            this.Information = information;
            this.Department = department;
            this.Nc32kId = nc32kId;
            this.Nc32kName = nc32kName;
            this.PersonKey = personKey;
            this.PersonID = personId;
            this.Card = card;
        }
    }
}
