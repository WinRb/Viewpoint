module RequestXml

CREATE_FOLDER=<<EOF
<?xml version="1.0"?>
<soap:Envelope xmlns:soap="http://schemas.xmlsoap.org/soap/envelope/" xmlns:t="http://schemas.microsoft.com/exchange/services/2006/types" xmlns:m="http://schemas.microsoft.com/exchange/services/2006/messages">
  <soap:Header>
    <t:RequestServerVersion Version="Exchange2010_SP2"/>
  </soap:Header>
  <soap:Body>
    <CreateFolder xmlns="http://schemas.microsoft.com/exchange/services/2006/messages">
      <ParentFolderId>
        <t:DistinguishedFolderId Id="msgfolderroot"/>
      </ParentFolderId>
      <Folders>
        <t:Folder>
          <t:DisplayName>Test Folder</t:DisplayName>
        </t:Folder>
      </Folders>
    </CreateFolder>
  </soap:Body>
</soap:Envelope>
EOF

COPY_FOLDER=<<EOF
<?xml version="1.0"?>
<soap:Envelope xmlns:soap="http://schemas.xmlsoap.org/soap/envelope/" xmlns:t="http://schemas.microsoft.com/exchange/services/2006/types" xmlns:m="http://schemas.microsoft.com/exchange/services/2006/messages">
  <soap:Header>
    <t:RequestServerVersion Version="Exchange2010_SP2"/>
  </soap:Header>
  <soap:Body>
    <CopyFolder xmlns="http://schemas.microsoft.com/exchange/services/2006/messages">
      <m:ToFolderId>
        <t:FolderId Id="dest_folder_id"/>
      </m:ToFolderId>
      <FolderIds>
        <t:FolderId Id="src_folder_id"/>
      </FolderIds>
    </CopyFolder>
  </soap:Body>
</soap:Envelope>
EOF

DELETE_FOLDER=<<EOF
<?xml version="1.0"?>
<soap:Envelope xmlns:soap="http://schemas.xmlsoap.org/soap/envelope/" xmlns:t="http://schemas.microsoft.com/exchange/services/2006/types" xmlns:m="http://schemas.microsoft.com/exchange/services/2006/messages">
  <soap:Header>
    <t:RequestServerVersion Version="Exchange2010_SP2"/>
  </soap:Header>
  <soap:Body>
    <DeleteFolder xmlns="http://schemas.microsoft.com/exchange/services/2006/messages" DeleteType="HardDelete">
      <FolderIds>
        <t:FolderId Id="test_folder_id"/>
      </FolderIds>
    </DeleteFolder>
  </soap:Body>
</soap:Envelope>
EOF

FIND_FOLDER=<<EOF
<?xml version="1.0"?>
<soap:Envelope xmlns:soap="http://schemas.xmlsoap.org/soap/envelope/" xmlns:t="http://schemas.microsoft.com/exchange/services/2006/types" xmlns:m="http://schemas.microsoft.com/exchange/services/2006/messages">
  <soap:Header>
    <t:RequestServerVersion Version="Exchange2010_SP2"/>
  </soap:Header>
  <soap:Body>
    <FindFolder xmlns="http://schemas.microsoft.com/exchange/services/2006/messages" Traversal="Deep">
      <FolderShape>
        <t:BaseShape>Default</t:BaseShape>
      </FolderShape>
      <m:Restriction>
        <t:IsEqualTo>
          <t:FieldURI FieldURI="folder:DisplayName"/>
          <t:FieldURIOrConstant>
            <t:Constant Value="Test Folder"/>
          </t:FieldURIOrConstant>
        </t:IsEqualTo>
      </m:Restriction>
      <m:ParentFolderIds>
        <t:DistinguishedFolderId Id="msgfolderroot"/>
      </m:ParentFolderIds>
    </FindFolder>
  </soap:Body>
</soap:Envelope>
EOF

EMPTY_FOLDER=<<EOF
<?xml version="1.0"?>
<soap:Envelope xmlns:soap="http://schemas.xmlsoap.org/soap/envelope/" xmlns:t="http://schemas.microsoft.com/exchange/services/2006/types" xmlns:m="http://schemas.microsoft.com/exchange/services/2006/messages">
  <soap:Header>
    <t:RequestServerVersion Version="Exchange2010_SP2"/>
  </soap:Header>
  <soap:Body>
    <EmptyFolder xmlns="http://schemas.microsoft.com/exchange/services/2006/messages" DeleteType="MoveToDeletedItems" DeleteSubFolders="false">
      <FolderIds>
        <t:FolderId Id="test_folder_id"/>
      </FolderIds>
    </EmptyFolder>
  </soap:Body>
</soap:Envelope>
EOF

end
