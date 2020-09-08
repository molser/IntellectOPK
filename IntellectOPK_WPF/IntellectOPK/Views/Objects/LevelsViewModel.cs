using System.Collections.Generic;
using IntellectOPK.Model;
using IntellectOPK.Utilities;
using System.Data;
using System;

namespace IntellectOPK.Views
{

    public class LevelsViewModel : ListViewModelBase
    {
        #region Member Data

        private ListView view;
        private List<Level> items;
        private AppObjectBase[] itemsArray;
        private IDataAccessService das = null;

        #endregion


        #region Constructor

        public LevelsViewModel(ListView view,
                                        List<Level> items,
                                        AppObjectBase[] selectedItems,
                                        IDataAccessService das)
            : base(view, das)
        {
            this.view = view;
            base.Title = "Уровни доступа";
            this.das = das;
            this.items = items;
            this.itemsArray = this.items.ToArray();
            base.ItemProperties.Add("IsChecked");
            base.ItemProperties.Add("Name");
            base.ItemProperties.Add("Description");
            base.ItemProperties.Add("Id");

            base.CheckItems(selectedItems);
            base.SubscribeOnItemChanged();
        }

        #endregion

        #region Properties
        public List<Level> Items
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
        public override bool FilterFindPredicate(object obj)
        {
            bool result = false;
            if (String.IsNullOrEmpty(base.FilterFindValue))
                return true;

            Level level = obj as Level;
            if (level != null)
            {                
                if (level.Name.ToUpper().Contains(base.FilterFindValue.ToUpper())) return true;
                return level.Description.ToUpper().Contains(base.FilterFindValue.ToUpper());
            }
            return result;
        }
        public override DataTable ExportTable
        {
            get
            {
                HashSet<string> columsForExport = new HashSet<string>();
                columsForExport.Add("Name");
                columsForExport.Add("Description");
                DataTable table = ExportHelper.ListToDataTable(this.items, columsForExport);
                return table;
            }
        }

        #endregion

    }
}
