using System.Collections.Generic;
using IntellectOPK.Model;
using IntellectOPK.Utilities;
using System.Data;


namespace IntellectOPK.Views
{

    public class EventsViewModel : ListViewModelBase
    {
        #region Member Data

        private ListView view;
        private List<Event> items;
        private AppObjectBase[] itemsArray;
        private IDataAccessService das = null;

        #endregion


        #region Constructor

        public EventsViewModel(ListView view,
                                        List<Event> items,
                                        AppObjectBase[] selectedItems,
                                        IDataAccessService das)
            : base(view, das)
        {
            this.view = view;
            base.Title = "События";
            this.das = das;
            this.items = items;
            this.itemsArray = this.items.ToArray();
            base.ItemProperties.Add("IsChecked");
            base.ItemProperties.Add("Description");
            base.ItemProperties.Add("Id");

            base.CheckItems(selectedItems);
            base.SubscribeOnItemChanged();
        }

        #endregion

        #region Properties
        public List<Event> Items
        {
            get { return this.items; }
            set
            {
                this.items = value;
                this.OnPropertyChanged("Items");
            }
        }
        #endregion

        #region ListViewModelBase
        public override AppObjectBase[] ItemsArray
        {
            get
            {
                return this.itemsArray;
            }
        }
        public override DataTable ExportTable
        {
            get
            {
                HashSet<string> columsForExport = new HashSet<string>();
                columsForExport.Add("Name");                
                DataTable table = ExportHelper.ListToDataTable(this.items, columsForExport);
                return table;
            }
        }

        #endregion
    }
}
