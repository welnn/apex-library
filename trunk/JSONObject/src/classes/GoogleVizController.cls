/* 
 * simple test class example
 * 
 * used from a Visualforce page controller to load some sample data into 
 * a Google Visualization, see ../pages/GoogleViz.page
 */
public class GoogleVizController { 
	public GoogleVizController() {}

    /* list all of the opportunities, load them into a table
     * that Google Visualization can read in
     */
    public string getData2() { 
        GoogleViz gv = new GoogleViz();
        gv.cols = new list<GoogleViz.col> { 
            new GoogleViz.Col('A','Id','t'),
            new GoogleViz.Col('B','Name','t'),
            new GoogleViz.Col('C','Amount','n'),
            new GoogleViz.Col('D','Close Date','d'),
            new GoogleViz.Col('E','Stage','t'),
            new GoogleViz.Col('f','Updated','s'),
            new GoogleViz.Col('g','Account','s'),
            new GoogleViz.Col('h','owner','s'),
            new GoogleViz.Col('i','Closed','b'),
            new GoogleViz.Col('i','Won','b')
             };
    
        for( Opportunity o: [select id,name,amount , closedate ,stagename 
                , createddate, isclosed,iswon, owner.name , account.name  from opportunity 
                  order by closeDate
                  limit 20
                 ]) { 
            googleViz.row rr = new googleViz.row();
            rr.cells.add ( new GoogleViz.cell( o.id ) );
            rr.cells.add ( new GoogleViz.cell( o.name ) );  
            rr.cells.add ( new GoogleViz.cell( o.amount ) ); // add formatted value?    
            rr.cells.add ( new GoogleViz.cell( o.closedate ) );
            rr.cells.add ( new GoogleViz.cell( o.stagename ) );
            rr.cells.add ( new GoogleViz.cell( o.createddate ) ); 
            rr.cells.add ( new GoogleViz.cell( o.account.name ) ); 
            rr.cells.add ( new GoogleViz.cell( o.owner.name ) ); 
            rr.cells.add ( new GoogleViz.cell( o.isclosed ) ); 
            rr.cells.add ( new GoogleViz.cell( o.iswon ) ); 
            gv.addRow( rr );   
        }       
        return gv.toJsonString(); 
    }
 
    public string getLineChartData() { 
        GoogleViz gv = new GoogleViz();
        gv.cols = new list<GoogleViz.col> { 
            new GoogleViz.Col('A','Date','d'),
            new GoogleViz.Col('b','Amount','n')  };
            
        for( Opportunity o: [select id,name,amount , closedate ,stagename 
                , createddate, isclosed,iswon, owner.name , account.name  from opportunity 
                  order by closeDate
                  limit 20   ]) { 
            googleViz.row rr = new googleViz.row();
            rr.cells.add ( new GoogleViz.cell( o.closedate ) );
            rr.cells.add ( new GoogleViz.cell( o.amount ) );
            gv.addRow( rr );   
        }   
        return gv.toJsonString(); 
    }
    
    public string gettimelineData() { 
        GoogleViz gv = new GoogleViz();
        gv.cols = new list<GoogleViz.col> { 
            new GoogleViz.Col('A','Date','d'),
            new GoogleViz.Col('b','Amount','n'),
            new GoogleViz.Col('c','Title1','t'),
            new GoogleViz.Col('d','Title2','t')
         };
            
        for( Opportunity o: [select id,name,amount , closedate ,stagename 
                ,isclosed,iswon,   account.name  
                from opportunity where isclosed = false
                  order by closeDate  ]) { 
            googleViz.row rr = new googleViz.row();
            rr.cells.add ( new GoogleViz.cell( o.closedate ) );
            rr.cells.add ( new GoogleViz.cell( o.amount ) );
            rr.cells.add ( new GoogleViz.cell( o.name ) );
            rr.cells.add ( new GoogleViz.cell( string.valueof(o.amount) ) );
            gv.addRow( rr );   
        } 
        
        System.debug('TESTING: ' + gv.toJsonString());  
        return gv.toJsonString(); 
    }
    
    public string getpieChartData() { 
    GoogleViz gv = new GoogleViz();
    gv.cols = new list<GoogleViz.col> { 
        new GoogleViz.Col('A','Name','s'),
        new GoogleViz.Col('b','Amount','n')  };
        for( Opportunity o: [select id,name,amount , closedate ,stagename 
                ,isclosed,iswon,   account.name  
                from opportunity where isclosed = false
                  order by closeDate limit 4 ]) { 
            googleViz.row rr = new googleViz.row();
            rr.cells.add ( new GoogleViz.cell( o.account.name ) );
            rr.cells.add ( new GoogleViz.cell( o.amount ) );
            gv.addRow( rr );   
        }   
        
        return gv.toJsonString(); 
    }
    
}